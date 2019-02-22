class ResultsController < ApplicationController
    def index
      #点数を受け取る
      score1 = params[:score1].to_i
      score2 = params[:score2].to_i
      score3 = params[:score3].to_i
      score4 = params[:score4].to_i

      #各点数の回数を受け取る
      count1 = params[:count1].to_i
      count2 = params[:count2].to_i
      count3 = params[:count3].to_i
      count4 = params[:count4].to_i

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
      puts 'オカ'
      puts oka

      uma_int_array = get_uma(uma)
      print('以下ウマ')
      puts uma_int_array[0]
      puts uma_int_array[1]
      puts uma_int_array[2]
      puts uma_int_array[3]
      
      #セレクトボックスから受け取ったウマを計算できるように変換


      #ポイントを算出
      #method化する
      # point2 = (score2 - kaesiten.to_i + uma2).fdiv(1000)
      # point3 = (score3 - kaesiten.to_i + uma3).fdiv(1000)
      # point4 = (score4 - kaesiten.to_i + uma4).fdiv(1000)
      # point1 = (point2 + point3 + point4) * -1

      # puts point2
      # puts point3
      # puts point4
      # puts point1


      #メソッドに渡すためにscoreとcountを配列化する
      score_array = [score1,score2,score3,score4]
      count_array = [count1,count2,count3,count4]


      #トータルゲーム数
      total_game_count = count1+count2+count3+count4
      print('totalgame数')
      puts total_game_count

      #平均順位を算出
      @average_rank = get_average_rank(count_array, total_game_count)

      #平均収支を算出
      @average_income_point = get_average_income_point(score_array, count_array, uma_int_array, kaesiten, oka, total_game_count)

      rank_rate_array = get_rank_rate(count_array, total_game_count)
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

    #各着順率取得method
    def get_rank_rate(count_array, total_game_count)
      puts 'count_array'
      puts count_array[0]
      puts 'total_game_count'
      puts total_game_count


      rank1_rate = count_array[0].to_i.fdiv(total_game_count) * 100
      puts 'rank1_rate'
      puts rank1_rate
      rank2_rate = count_array[1].to_i.fdiv(total_game_count) * 100
      rank3_rate = count_array[2].to_i.fdiv(total_game_count) * 100
      rank4_rate = count_array[3].to_i.fdiv(total_game_count) * 100
      rank_rate_array = [rank1_rate, rank2_rate, rank3_rate, rank4_rate]
      return rank_rate_array
    end

  end
  