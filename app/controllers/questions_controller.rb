class QuestionsController < ApplicationController
  before_action :set_question, only: [:show, :edit, :update, :destroy, :answer, :nobody_knows]
  before_action :set_questions, only: [:index, :admin]

  # GET /questions
  def index
  end

  # GET /questions/1
  def show
  end

  # GET /questions/new
  def new
    @question = Question.new
  end

  # GET /questions/1/edit
  def edit
  end

  def answer
    player = Player.find(params[:player_id])
    if params[:success]
      player.account = player.account + @question.cost
    else
      player.account = player.account - @question.cost
    end
    player.save!
    if params[:success]
      @question.answered = true
      @question.save!
      redirect_to questions_url
    else
      redirect_to @question
    end
  end

  def nobody_knows
    @question.answered = true
    @question.save!
    redirect_to questions_url
  end

  # POST /questions
  def create
    @question = Question.new(question_params)

    if @question.save
      redirect_to admin_questions_url, notice: 'Question was successfully created.'
    else
      render action: 'new'
    end
  end

  # PATCH/PUT /questions/1
  def update
    if @question.update(question_params)
      redirect_to admin_questions_url, notice: 'Question was successfully updated.'
    else
      render action: 'edit'
    end
  end

  # DELETE /questions/1
  def destroy
    @question.destroy
    redirect_to admin_questions_url, notice: 'Question was successfully destroyed.'
  end

  def reset
    Question.update_all(answered: false)
    redirect_to admin_questions_url, notice: 'All questions are unanswered now.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_question
      @question = Question.find(params[:id])
    end

    def set_questions
      @questions = Question.order('cost').all
    end

    # Only allow a trusted parameter "white list" through.
    def question_params
      params[:question].permit(:topic, :cost, :q, :a, :answered)
    end
end
