class TasksController < ApplicationController
  before_action :require_user_logged_in
  before_action :correct_user, only: [:show, :edit, :update, :destroy]
  
  
  def index
    @tasks = current_user.tasks
  end
  
  def show
    correct_user
  end

  def new
    @task = Task.new
  end
  
  def create
    @task = current_user.tasks.build(task_params)
    
    if @task.save
      flash[:success] = 'Task が正常に投稿されました'
      redirect_to @task
    else
      flash.now[:danger] = 'Task が投稿されませんでした'
      render :new
    end
  end

  def edit
    correct_user
  end
  
  def update
    correct_user
    
    if @task.update(task_params)
      flash[:success] = 'Task は正常に更新されました'
      redirect_to @task
    else
      flash.now[:danger] = 'Task は更新されませんでした'
      render :edit
    end
  end
  
  def destroy
    correct_user
    @task.destroy
    
    flash[:success] = 'Task は正常に削除されました'
    redirect_to tasks_url
  end
  
  private
  
  def correct_user
    @micropost = current_user.microposts.find_by(id: params[:id])
    unless @micropost
      redirect_to root_url
    end
  end
  
  def task_params
    params.require(:task).permit(:content, :status)
  end

end