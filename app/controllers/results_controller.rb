class ResultsController < ApplicationController
    def index
      score1 = params[:score1]
      score2 = params[:score2]
      score3 = params[:score3]
      score4 = params[:score4]

      count1 = params[:count1].to_i
      count2 = params[:count2].to_i
      count3 = params[:count3].to_i
      count4 = params[:count4].to_i

      score_array = [score1,score2,score3,score4]
      count_array = [count1,count2,count3,count4]
      puts score_array
      puts count_array

      #トータルゲーム数
      total_game_count = count1+count2+count3+count4

      #平均順位を算出
      @average_rank = (count1*1+count2*2+count3*3+count4*4).fdiv(total_game_count)
    end

    #平均収支を算出するメソッド
    def get_average_income(score_array, count_array, uma, genten, kaesiten)

    end

  end
  