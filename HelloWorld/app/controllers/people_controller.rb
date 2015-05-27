class PeopleController < ApplicationController
  before_action :set_person, only: [:show, :edit, :update, :destroy]

  # GET /people
  # GET /people.json
  def index
    @people = Person.all
  end

  # GET /people/1
  # GET /people/1.json
  def show
  end

  # GET /people/new
  def new
    @person = Person.new
  end

  # GET /people/1/edit
  def edit
  end

  # POST /people
  # POST /people.json
  def create
    @person = Person.new(person_params)

    @matchingPerson = Person.where("FirstName = ? AND LastName = ?", @person.FirstName, @person.LastName).first

    respond_to do |format|

    if @matchingPerson.present?
        @noticeString = sprintf('I already know who you are %s %s !', @matchingPerson.FirstName, @matchingPerson.LastName)

        @person.errors[:base] << @noticeString
        format.html { render :new}
        format.json { render json: @person.errors, status: :unprocessable_entity }

    else      
          @createString = sprintf("%s %s was successfully created.", @person.FirstName, @person.LastName)
          if @person.save
            format.html { redirect_to @person, notice: @createString }
            format.json { render :show, status: :created, location: @person }
          else
            format.html { render :new }
            format.json { render json: @person.errors, status: :unprocessable_entity }
          end
       end
    end
  end

  # PATCH/PUT /people/1
  # PATCH/PUT /people/1.json
  def update
    @updateString = sprintf('%s %s was successfully updated.', @person.FirstName, @person.LastName)
    respond_to do |format|
      if @person.update(person_params)
        format.html { redirect_to @person, notice: @updateString }
        format.json { render :show, status: :ok, location: @person }
      else
        format.html { render :edit }
        format.json { render json: @person.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /people/1
  # DELETE /people/1.json
  def destroy
    @personCopy = @person
    @destroyString = sprintf('Sorry to see you go - %s %s :\'-).', @person.FirstName, @person.LastName)
    @person.destroy
    respond_to do |format|
      format.html { redirect_to people_url, notice: @destroyString }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_person
      @person = Person.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def person_params
      params.require(:person).permit(:FirstName, :LastName, :age)
    end
end
