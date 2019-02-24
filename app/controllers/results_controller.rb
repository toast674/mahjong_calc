class ResultsController < ApplicationController
    def index

      game_type = params[:game_type]
      puts 'game_type'
      puts game_type
      #収支戦 点数を受け取る 
      shuushisen_score1 = params[:shuushisen_score1].to_i
      shuushisen_score2 = params[:shuushisen_score2].to_i
      shuushisen_score3 = params[:shuushisen_score3].to_i
      shuushisen_score4 = params[:shuushisen_score4].to_i

      #収支戦 各点数の回数を受け取る
      shuushisen_count1 = params[:shuushisen_count1].to_i
      shuushisen_count2 = params[:shuushisen_count2].to_i
      shuushisen_count3 = params[:shuushisen_count3].to_i
      shuushisen_count4 = params[:shuushisen_count4].to_i

      #順位戦 点数を受け取る 
      junisen_score1 = params[:junisen_score1].to_i
      junisen_score2 = params[:junisen_score2].to_i
      junisen_score3 = params[:junisen_score3].to_i
      junisen_score4 = params[:junisen_score4].to_i

      #順位戦 各点数の回数を受け取る
      junisen_count1 = params[:junisen_count1].to_i
      junisen_count2 = params[:junisen_count2].to_i
      junisen_count3 = params[:junisen_count3].to_i
      junisen_count4 = params[:junisen_count4].to_i

      #原点・返し点をセレクトボックスから受け取る
      genten = params[:genten]
      kaesiten = params[:kaesiten]
      #ウマをセレクトボックスから受け取る
      uma = params[:uma]

      #原点・返し点を計算できるように変換
      genten = genten.delete("点")
      kaesiten = kaesiten.delete("点")
      #原点・返し点をもとにオカを算出
      oka = (genten.to_i - kaesiten.to_i) * -4

      uma_int_array = get_uma(uma)

      #メソッドに渡すためにscoreとcountを配列化する
      shuushisen_score_array = [shuushisen_score1,shuushisen_score2,shuushisen_score3,shuushisen_score4]
      shuushisen_count_array = [shuushisen_count1,shuushisen_count2,shuushisen_count3,shuushisen_count4]

      junisen_score_array = [junisen_score1,junisen_score2,junisen_score3,junisen_score4]
      junisen_count_array = [junisen_count1,junisen_count2,junisen_count3,junisen_count4]

      #トータルゲーム数
      shuushisen_total_game_count = shuushisen_count1+shuushisen_count2+shuushisen_count3+shuushisen_count4
      junisen_total_game_count = junisen_count1+junisen_count2+junisen_count3+junisen_count4
      print('totalgame数')
      puts shuushisen_total_game_count

      #平均順位を算出
      @average_rank = get_average_rank(shuushisen_count_array, shuushisen_total_game_count)

      #平均収支を算出
      @average_income_point = get_average_income_point(shuushisen_score_array, shuushisen_count_array, uma_int_array, kaesiten, oka, shuushisen_total_game_count)

      @average_point = get_average_point(junisen_score_array, junisen_count_array, junisen_total_game_count)

      rank_rate_array = get_rank_rate(shuushisen_count_array, shuushisen_total_game_count)
      puts '順位率配列'
      puts rank_rate_array
      @rank1_rate = rank_rate_array[0]
      @rank2_rate = rank_rate_array[1]
      @rank3_rate = rank_rate_array[2]
      @rank4_rate = rank_rate_array[3]

    end

    #ウマ変換method
    def get_uma(uma)
      uma_split = uma.split("-")
      uma1 = uma_split[1].to_i * 1000
      uma2 = uma_split[0].to_i * 1000
      uma3 = uma_split[0].to_i * -1000
      uma4 = uma_split[1].to_i * -1000

      uma_int_array = [uma1,uma2,uma3,uma4]
      return uma_int_array
    end

    #平均順位取得method
    def get_average_rank(count_array, total_game_count)
      average_rank = 
      (count_array[0].to_i*1+
      count_array[1].to_i*2+
      count_array[2].to_i*3+
      count_array[3].to_i*4).fdiv(total_game_count)

      average_rank = average_rank.round(3)
      return average_rank
    end


    #平均収支算出method
    def get_average_income_point(score_array, count_array, uma_int_array, kaesiten, oka, total_game_count)
      average_income_point = 
      ((score_array[1].to_i - kaesiten.to_i + uma_int_array[1]) * count_array[1].to_i.fdiv(100) + #各順位での平均収支算出
      (score_array[2].to_i - kaesiten.to_i + uma_int_array[2]) * count_array[2].to_i.fdiv(100) +
      (score_array[3].to_i - kaesiten.to_i + uma_int_array[3]) * count_array[3].to_i.fdiv(100) +
      (score_array[0].to_i - kaesiten.to_i + uma_int_array[0] + oka.to_i ) * count_array[0].to_i.fdiv(100)).fdiv(total_game_count)

      average_income_point = average_income_point.round(3)

      return average_income_point
    end

    #順位戦平均獲得ポイント算出method
    def get_average_point(junisen_score_array, junisen_count_array, junisen_total_game_count)
      avarage_point = 
      ((junisen_score_array[0] * junisen_count_array[0]) + 
      (junisen_score_array[1] * junisen_count_array[1]) + 
      (junisen_score_array[2] * junisen_count_array[2]) + 
      (junisen_score_array[3] * junisen_count_array[3])).fdiv(junisen_total_game_count)

      avarage_point = avarage_point.round(3)
      return avarage_point

    end

    #各着順率取得method
    def get_rank_rate(count_array, total_game_count)
      rank1_rate = count_array[0].to_i.fdiv(total_game_count) * 100 
      rank2_rate = count_array[1].to_i.fdiv(total_game_count) * 100
      rank3_rate = count_array[2].to_i.fdiv(total_game_count) * 100
      rank4_rate = count_array[3].to_i.fdiv(total_game_count) * 100

      rank1_rate = rank1_rate.round(3)
      rank2_rate = rank2_rate.round(3)
      rank3_rate = rank3_rate.round(3)
      rank4_rate = rank4_rate.round(3)

      rank_rate_array = [rank1_rate, rank2_rate, rank3_rate, rank4_rate]
      return rank_rate_array
    end



  end
  