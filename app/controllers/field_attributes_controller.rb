class FieldAttributesController < ApplicationController
  before_action :find_field, only: %i[edit update]
  def index
    @filtered_fields = FieldAttribute.ransack(params[:search])
    @pagy, @fields = pagy @filtered_fields.result
  end
  
  def new; end

  def create
    @field = FieldAttribute.create(field_params)
    if @field.errors.blank?
      redirect_to field_attributes_path
    else
      render :new
    end
  end

  def edit; end

  def update
    if @field.update(field_params)
      redirect_to field_attributes_path, notice: 'Field updated successfully!'
    else
      render :edit, alert: @field.errors.full_messages.to_sentence
    end
  end
  
  private

  def find_field
    @field = FieldAttribute.find_by(id: params[:id])

    redirect_to field_attributes_path if @field.blank?
  end

  def field_params
    params.require(:field_attribute).permit(:index, :statement, :statement_ar, :label, :label_ar,
                                            :description, :description_ar, :is_required, :is_multiple,
                                            :add_more_label, :add_more_label_ar, :decription_link,
                                            options_attributes: %i[id statement statement_ar label label_ar])
  end
end
