class GroupsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create, :edit, :update, :destroy]
  before_action :find_group_and_check_permission, only: [:edit, :update, :destroy]
  def index
    @groups = Group.all
  end

  def show
    @group = Group.find(params[:id])
    # @posts = @group.posts
    # @posts = @group.posts.order("created_at DESC")
      # @posts = @group.posts.recent
      # @posts = @group.posts.recent.paginate(:page => params[:page], :per_page => 5) 换一种写法
        @posts = @group.posts.recent.paginate(page: params[:page], per_page: 5)
        # class: "btn btn-primary", :class => "btn btn-primary",
  end

  def edit

  end

  def new
    @group = Group.new
  end

  def create
    @group = Group.new(group_params)
    @group.user = current_user
    if @group.save

      # 以下是完成建立 group 后自动成为 group 的一员
      current_user.join!(@group)
      # 其实是引用了user.rb中
      # def join!(group)
      #     participated_groups << group
      #   end

    redirect_to groups_path
    else
      render :new
    end
  end

  def update


    if @group.update(group_params)
    redirect_to groups_path, notice: "update success"
  else
    render :edit
  end
  end

  def destroy

    @group.destroy
    flash[:alert] = "group deleted"
    redirect_to groups_path
  end

  def join
    @group = Group.find(params[:id])

    if !current_user.is_member_of?(@group)
      current_user.join!(@group)
      flash[:notice] = "welcome to this topic and be team member"
    else
      flash[:warning] = "u already be team member"
      # 上面这条flash语句 只有在rails c里面修改过属性 才会出现 否则逻辑上不会有这种情况
    end
    redirect_to group_path(@group)
  end

  def quit
    @group = Group.find(params[:id])

    if current_user.is_member_of?(@group)
      current_user.quit!(@group)
    flash[:alert] = "quit the door and be free"
  else
    flash[:warning] = "you are not team member how to quit"
    # 上面这条flash语句 只有在rails c里面修改过属性 才会出现 否则逻辑上不会有这种情况
  end
    redirect_to group_path(@group)
  end
private


  def find_group_and_check_permission
    @group = Group.find(params[:id])
    if current_user != @group.user
      redirect_to root_path, alert: "you have no permission"
    end
  end

  def group_params
    params.require(:group).permit(:title, :description)
  end
end
