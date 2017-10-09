class TasksController < ApplicationController
  before_action :authenticate, except: [:index]
  before_action :set_task, only: [:edit, :update, :destroy, :start, :stop]

  def index
    @tasks = Task.all
  end

  def new
    @task = Task.new
  end

  def create
    @task = Task.new(task_params)
    if @task.save
      redirect_to tasks_url, notice: 'Task was successfully created.'
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @task.update(task_params)
      redirect_to tasks_url, notice: 'Task was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @task.destroy
    redirect_to tasks_url, notice: 'Task was successfully destroyed.'
  end

  def start
    @task.start
    redirect_to tasks_url, notice: 'Task was successfully started.'
  end

  def stop
    @task.stop
    redirect_to tasks_url, notice: 'Task was successfully stopped.'
  end

private
  def set_task
    @task = Task.find(params[:id])
  end

  def task_params
    params.require(:task).permit(:name, :mode_type, :delay)
  end
end
