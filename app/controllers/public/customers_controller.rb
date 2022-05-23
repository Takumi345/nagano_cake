class Public::CustomersController < ApplicationController
  def show
    @customer = current_customer
  end

  def edit
    @customer = current_customer
  end

  def update
    @customer = current_customer
    @customer.update(customer_params)
    redirect_to public_customers_path(current_customer)
  end

  def confirm
  end

  def withdraw
    @customer = current_customer
    @customer.update(is_deleted: true)
    sign_out current_customer
    redirect_to root_path
  end
end


  private

  def customer_params
    params.require(:customer).permit(:last_name, :first_name, :last_name_kana, :first_name_kana, :telephone_number, :postal_code, :address, :email, :is_deleted)
  end