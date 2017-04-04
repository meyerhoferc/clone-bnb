class CodesController < ApplicationController
  def new
    @code = Code.new
  end

  def create
    @code = Code.new(code_params)
    @code.user = User.find_by(phone_number: @code.phone_number)
    @code.body = @code.twilio_service.send_password_code(@code.phone_number)
    if @code.body && @code.save
      flash[:success] = "Code sent to #{@code.phone_number}"
      session[:code_id] = @code.id
      redirect_to edit_code_path(@code)
    else
      flash[:danger] = "Please try to enter your phone number again"
      render :new
    end
  end

  def edit
    @code = Code.find(params[:id])
  end

  def update
    @code = Code.find(params[:id])
    if @code.body == params[:code][:body]
      redirect_to reset_password_path(code_id: @code.id)
    else
      flash[:danger] = "Please try to enter the code again"
      render :edit
    end
  end

  def reset
    @code = Code.find(params[:code_id])
  end

  def update_password
    user = Code.find(session[:code_id]).user
    user.update(password: params[:code][:password])
    if user.save
      flash[:success] = "Password successfully changed"
      redirect_to login_path
    else
      flash[:danger] = "Please make sure you entered the passwords correctly"
      render :reset
    end
  end

  private

  def code_params
    params.require(:code).permit(:phone_number)
  end
end
