class SteppersController < ApplicationController
  before_action :find_step, only: %i[edit update]
  def index
    @filtered_steps = Stepper.ransack(params[:search])
    @pagy, @steps = pagy @filtered_steps.result.order(:id)
  end
  
  def new; end

  def create
    @step = Stepper.create(step_params)
    if @step.errors.blank?
      redirect_to steppers_path
    else
      render :new
    end
  end

  def edit; end

  def update
    if @step.update(step_params)
      redirect_to steppers_path, notice: 'Step updated successfully!'
    else
      render :edit, alert: @step.errors.full_messages.to_sentence
    end
  end
  
  private

  def find_step
    @step = Stepper.find_by(id: params[:id])

    redirect_to stepper_attributes_path if @step.blank?
  end

  def step_params
    params.require(:stepper).permit(:title, :title_ar,
                                              sections_attributes: %i[id title title_ar description description_ar
                                                                      add_more_label add_more_label_ar description_link])
  end
end
