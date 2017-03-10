class ItemsController < ApplicationController
	before_action :find_item, only: [:edit, :show, :destroy, :update]
	def index
		if user_signed_in?
		@items=Item.where(:user_id => current_user.id).order("created_at Desc")
	end
end

	def new 
		@item=current_user.items.build
end

   def edit
 	end

 	def update
 		@item=Item.update(item_params)
 		if redirect_to item_path(@item)
 		else
 			render 'edit'
 		end
 	end
 		def destroy
		@item.destroy
		redirect_to root_path
	     end
        def complete
        	@item=Item.find(params[:id])
        	@item.update_attribute(:completed_at,Time.now)
        	redirect_to root_path
        end

     def show
     	 #@item=Item.find(params[:id])
     	end


	def create 
		@item=current_user.items.build(item_params)
			if @item.save
				redirect_to root_path
			else
			render 'new'
			end	
end

    private
    
      def item_params
	params.require(:item).permit(:title, :description)
end
 def find_item
 	 @item = Item.find(params[:id])
 	end
end
