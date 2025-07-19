class DestinationsController < ApplicationController
  before_action :set_destination, only: [ :show, :edit, :update, :destroy, :complete_walk ]

  def index
    @destinations = current_user.destinations
    @user_monster = current_user.user_monster
    @species = @user_monster&.monster_species

  end

  def create
    @destination = current_user.destinations.new(destination_params)
    if @destination.save
      redirect_to destinations_path, notice: "冒険記録を保存しました"
    else
      flash.now[:alert] = "保存に失敗しました: #{@destination.errors.full_messages.to_sentence}"
      @destinations = current_user.destinations
      @user_monster = current_user.user_monster
      @species = @user_monster&.monster_species
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

  # 「歩いた」ボタン押下時の処理（経験値付与）
  def complete_walk
    if @destination.walked_at.nil?
      @destination.walked_at = Time.current
      distance_km = @destination.distance.to_s.gsub(",", "").gsub(" km", "").to_f
      distance_in_meters = distance_km * 1000.0

      exp = (distance_in_meters / 100.0 * 10).floor # 100mあたり10EXP

      user_monster = current_user.user_monster
      if user_monster
        user_monster.experience += exp
        user_monster.recalculate_level!  # ←ここでレベル再計算！
        user_monster.save!
      end

      @destination.save
      redirect_back fallback_location: destination_path(@destination), notice: "お疲れ様！モンスターが#{exp}EXPを獲得して、成長したよ！"
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
