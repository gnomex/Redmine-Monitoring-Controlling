class McTimeMgmtProjectController < ApplicationController
  unloadable

  layout 'base'
  before_filter :find_project, :authorize
  menu_item :redmine_monitoring_controlling
    
  def index
    #tool instance
    tool = McTools.new
    
    #get main project
    @project = Project.find_by_identifier(params[:id])

    #get projects and sub projects
    stringSqlProjectsSubProjects = tool.return_ids(@project.id)   
    
    # total issues from the project and subprojects
    @totalIssues = Issue.where(:project_id => [stringSqlProjectsSubProjects]).count


    @issuesSpentHours = Issue.find_by_sql("select
                                             parent.due_date,
                                             sum(issues.estimated_hours) as estimated_hours,
                                             (select sum(i.estimated_hours) from issues i join issues ip on ip.id = i.root_id and ip.due_date is not null where i.project_id in (#{stringSqlProjectsSubProjects}) and ip.due_date <= parent.due_date) as sumestimatedhours,
                                             (select sum(hours) from time_entries where project_id in (#{stringSqlProjectsSubProjects}) and spent_on <= parent.due_date ) as sumspenthours
                                           from issues
                                             join issues parent on
                                               parent.id = issues.root_id and
                                               parent.due_date is not null
                                           where issues.project_id in (#{stringSqlProjectsSubProjects})
                                           group by parent.due_date
                                           order by parent.due_date;")    
                                        

    @spentHoursByVersion = Issue.find_by_sql("select versions.name as version, versions.effective_date, sum(issues.estimated_hours) as estimated_hours, 
                                             (select sum(i.estimated_hours) 
                                              from issues i
                                              where i.project_id in (#{stringSqlProjectsSubProjects})
                                              and i.fixed_version_id = versions.id
                                              /*and i.due_date is not null*/
                                              and i.parent_id is null 
                                              and i.due_date <= versions.effective_date) as sumestimatedhours,
                                             (select sum(hours) 
                                              from issues i, time_entries t
                                              where i.project_id in (#{stringSqlProjectsSubProjects})
                                              and i.project_id = t.project_id
                                              and i.id = t.issue_id
                                              and i.fixed_version_id = versions.id
                                              and t.spent_on <= versions.effective_date) as sumspenthours
                                             from issues, versions 
                                             where issues.project_id in (#{stringSqlProjectsSubProjects})
                                             and issues.parent_id is null
                                             and issues.fixed_version_id = versions.id
                                             and due_date <= versions.effective_date
                                             group by versions.id, versions.name, versions.effective_date
                                             order by versions.effective_date;")
                                      

  end

  private
  def find_project
    @project=Project.find(params[:id])
  end


end
