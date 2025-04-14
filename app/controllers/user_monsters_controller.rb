class UserMonstersController < ApplicationController
    def index
      @user_monster = current_user.user_monster

      if @user_monster.present?
        @species = @user_monster.monster_species
      else
        #モンスター未所持時の処理
        redirect_to new_user_monster_path, alert: 'まずはモンスターを選びましょう！'
      end
    end

    def new
        @monster_species = MonsterSpecies.limit(3) 
        @user_monster = UserMonster.new
    end

    def create
        @user_monster = current_user.build_user_monster(
          monster_species_id: params[:monster_species_id],
          level: 1,
          experience: 0
        )
        if @user_monster.save
          redirect_to user_monsters_path, notice: 'モンスターを選びました！'
        else
          redirect_to new_user_monster_path, alert: 'モンスターの選択に失敗しました'
        end
    end
end
