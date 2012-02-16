class <%= controller_class_name %>Controller < ApplicationController
  before_filter :find_<%= nested_parent_name %>
  before_filter :find_<%= singular_name %>, :only => [:show, :edit, :update, :destroy]

  # GET <%= plural_nested_parent_name %>/1/<%= plural_name %>
  # GET <%= plural_nested_parent_name %>/1/<%= plural_name %>.xml
  def index
    <%= "@#{plural_name} = @#{nested_parent_name}.#{plural_name}" %>

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @<%= plural_name %> }
    end
  end

  # GET <%= plural_nested_parent_name %>/1/<%= plural_name %>/1
  # GET <%= plural_nested_parent_name %>/1/<%= plural_name %>/1.xml
  def show
    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @<%= singular_name %> }
    end
  end

  # GET <%= plural_nested_parent_name %>/1/<%= plural_name %>/new
  # GET <%= plural_nested_parent_name %>/1/<%= plural_name %>/new.xml
  def new
    <%= "@#{singular_name} = #{nested_parent_class_name}.find(params[:#{nested_parent_id}]).#{plural_name}.build" %>

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @<%= singular_name %> }
    end
  end

  # GET <%= plural_nested_parent_name %>/1/<%= plural_name %>/1/edit
  def edit
  end

  # POST <%= plural_nested_parent_name %>/1/<%= plural_name %>
  # POST <%= plural_nested_parent_name %>/1/<%= plural_name %>.xml
  def create
    <%= "@#{singular_name} = @#{nested_parent_name}.#{plural_name}.build(params[:#{singular_name}])" %>

    respond_to do |format|
      if @<%= singular_name %>.save
        format.html { redirect_to([@<%= singular_name %>.<%= nested_parent_name %>, @<%= singular_name %>], :notice => '<%= human_name %> was successfully created.') }
        format.xml  { render :xml => @<%= singular_name %>, :status => :created, :location => [@<%= singular_name %>.<%= nested_parent_name %>, @<%= singular_name %>] }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @<%= singular_name %>.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT <%= plural_nested_parent_name %>/1/<%= plural_name %>/1
  # PUT <%= plural_nested_parent_name %>/1/<%= plural_name %>/1.xml
  def update
    respond_to do |format|
      if @<%= singular_name %>.update_attributes(params[:<%= singular_name %>])
        format.html { redirect_to([@<%= singular_name %>.<%= nested_parent_name %>, @<%= singular_name %>], :notice => '<%= human_name %> was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @<%= singular_name %>.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE <%= plural_nested_parent_name %>/1/<%= plural_name %>/1
  # DELETE <%= plural_nested_parent_name %>/1/<%= plural_name %>/1.xml
  def destroy
    @<%= singular_name %>.destroy

    respond_to do |format|
      format.html { redirect_to <%= nested_parent_name %>_<%= index_helper %>_url }
      format.xml  { head :ok }
    end
  end

  protected

    def find_<%= nested_parent_name %>
      @<%= nested_parent_name %> = admin? ? <%= nested_parent_class_name %>.find(params[:<%= nested_parent_name %>_id]) : current_user.<%= plural_nested_parent_name %>.find(params[:<%= nested_parent_name %>_id])
    end

    def find_<%= singular_name %>
      @<%= singular_name %> = @<%= nested_parent_name %>.<%= plural_name %>.find(params[:id])
    end

end
