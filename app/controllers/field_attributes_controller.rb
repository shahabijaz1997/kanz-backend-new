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
    @field.update(field_params)
  end
  
  private

  def find_field
    @field = FieldAttribute.find_by(id: params[:id])

    redirect_to field_attributes_path if @field.blank?
  end

  def field_params
    params.require(:field_attribute).permit(%i[index statement statement_ar label label_ar description
                                               description_ar is_required is_multiple
                                               add_more_label add_more_label_ar field_type decription_link
                                               permitted_types size_constraints suggestions input_type])
  end
end
