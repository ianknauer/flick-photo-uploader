class CustomersController < ApplicationController
  before_action :set_customer, only: [:edit, :update, :show]

  def index
    @customers = Customer.limit(3)
  end

  def show
  end

  def new
    @customer = Customer.new
  end

  def create
    @customer = Customer.new(customer_params)
    if @customer.save
      flash[:success] = "You have successfully created #{@customer.first_name} as a customer."
      redirect_to customers_path
    else
      flash[:error] = "Something went wrong with your submission, try again"
      render :new
    end
  end

  def edit
  end

  def update
    if @customer.update(customer_params)
      flash[:notice] = "The customer info was updated"
      redirect_to customers_path
    else
      flash[:error] = "You tried to make a change that i can't allow. Try again!"
      render :edit
    end
  end

  def search
    @results = Customer.search(params[:search_term])
  end

  private

  def customer_params
    params.require(:customer).permit(:first_name, :last_name, :email)
  end

  def set_customer
    @customer = Customer.find(params[:id])
  end
end
