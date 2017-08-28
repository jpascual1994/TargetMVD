class Users::ConfirmationsController < Devise::ConfirmationsController

  # GET /resource/confirmation?confirmation_token=abcdef
  def show
    self.resource = resource_class.confirm_by_token(params[:confirmation_token])
    yield resource if block_given?

    unless resource.errors.empty?
      respond_with_navigational(resource.errors, status: :unprocessable_entity){ render :new }
    end
  end
end
