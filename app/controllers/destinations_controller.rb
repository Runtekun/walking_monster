class DestinationsController < ApplicationController
  before_action :set_destination, only: [:show, :edit, :update, :destroy, :complete_walk]

  def index
    @destinations = current_user.destinations
  end

  def create
    @destination = current_user.destinations.new(destination_params)
    if @destination.save
      redirect_to destinations_path, notice: "あなたの行き先予定の経路を保存しました"
    else
      flash.now[:alert] = "保存に失敗しました: #{@destination.errors.full_messages.to_sentence}"
      @destinations = current_user.destinations
      render :index
    end
  end

  def show
  end

  def edit
  end

  def update
    if @destination.update(destination_params)
      redirect_to @destination, notice: "更新に成功しました"
    else
      render :edit, alert: "更新に失敗しました: #{@destination.errors.full_messages.to_sentence}"
    end
  end

  def destroy
    if @destination
      @destination.destroy
      redirect_to destinations_path, notice: "あなたの行き先リストの経路を削除しました"
    else
      redirect_to destinations_path, alert: "指定された経路は見つかりませんでした"
    end
  end

  #「歩いた」ボタン押下時の処理（経験値付与）
  def complete_walk
    if @destination.walked_at.nil?
      @destination.walked_at = Time.current
      exp = (@destination.distance.to_f / 100.0 * 10).floor # 100mあたり10EXP
      
      # 1体のモンスターにEXP加算
      user_monster = current_user.user_monster
      user_monster&.update(experience: user_monster.experience + exp)
  
      @destination.save
      redirect_to destination_path(@destination), notice: "お疲れ様！モンスターが#{exp}EXPを獲得したよ！"
    else
      redirect_to destination_path(@destination), alert: "この経路はすでに完了しています。"
    end
  end

  private

  def set_destination
    @destination = current_user.destinations.find_by(id: params[:id])
    unless @destination
      redirect_to destinations_path, alert: "指定された経路は見つかりませんでした"
    end
  end

  def destination_params
    params.require(:destination).permit(:start, :end, :distance, :duration, :steps)
  end
end