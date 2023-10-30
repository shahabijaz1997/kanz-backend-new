class StepperController < ApplicationController
  def index
  end

  def new
    @stepper = Stepper.new
  end

  def edit
  end

  def create
    @stepper = Stepper.new(stepper_params)
  end

  private

  def stepper_params
    params.require(:stepper).permit(%i[index title title_ar stepper_type])
  end
end
