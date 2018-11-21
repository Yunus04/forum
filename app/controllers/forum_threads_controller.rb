class ForumThreadsController < ApplicationController

	before_action :authenticate_user!, only: [:new, :create]

	def index
		if params[:search]
			@threads = ForumThread.where('title like ?', "%#{params[:search]}%").paginate(per_page: 5, page: params[:page]) 
			else
				@threads = ForumThread.order(sticy_order: :asc).order(id: :desc).paginate(per_page: 5, page: params[:page])
		end
	end

	def show
		@thread = ForumThread.friendly.find(params[:id])
		@post = ForumPost.new
		@posts = @thread.forum_posts.paginate(per_page: 3, page: params[:page])
	end

	def new
		@thread = ForumThread.new
	end

	def create
		@thread = ForumThread.new(resource_params)
		@thread.user = current_user
		if @thread.save
			puts 'sukses disimpan'
			redirect_to root_path
		else
			render 'new'
	end

	end

	def pinit
		@thread = ForumThread.friendly.find(params[:id])
		@thread.pinit!
		redirect_to root_path
	end

	def edit
		@thread = ForumThread.friendly.find(params[:id])
		authorize @thread
	end

	def destroy
		@thread = ForumThread.friendly.find(params[:id])
		authorize @thread

		@thread.destroy
		redirect_to root_path, notice: 'Thread berhasil di hapus'
	end	

	def update
		@thread = ForumThread.friendly.find(params[:id])
		authorize @thread
		
		if @thread.update(resource_params)
			
			redirect_to forum_thread_path(@thread)
		else
			render 'new'
		end	
	end

	private

	def resource_params
		params.require(:forum_thread).permit(:title, :content)
	end
end