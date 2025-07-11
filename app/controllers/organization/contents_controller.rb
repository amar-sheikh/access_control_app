class Organization::ContentsController < Organization::BaseController
  load_and_authorize_resource class: 'Content'

  before_action :set_content, only: %i[ show edit update destroy ]

  def index
    @contents = @organization.contents
  end

  def show
  end

  def new
    @content = @organization.contents.new
  end

  def edit
  end

  def create
    @content = Content.new(content_params)
    @content.organization = @organization
    @content.created_by = @current_org_user

    if @content.save
      redirect_to organization_content_url(@content), notice: "Content was successfully created."
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    if @content.update(content_params)
      redirect_to organization_content_url(@content), notice: "Content was successfully updated."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @content.destroy!

    redirect_to organization_contents_path, status: :see_other, notice: "Content was successfully destroyed."
  end

  private
    def set_content
      @content = Content.find(params[:id])
    end

    def content_params
      params.require(:content).permit(:title, :text, :require_parent_concent, :age_group, :organization_id)
    end
end
