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
      puts oka

      uma_int_array = change_uma(uma)
      print('以下ウマ')
      puts uma_int_array[0]
      puts uma_int_array[1]
      puts uma_int_array[2]
      puts uma_int_array[3]



      puts genten
      puts kaesiten
      puts uma
      
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

      puts kaesiten

      #メソッドに渡すためにscoreとcountを配列化する
      score_array = [score1,score2,score3,score4]
      count_array = [count1,count2,count3,count4]


      #トータルゲーム数
      total_game_count = count1+count2+count3+count4
      print('totalgame数')
      puts total_game_count

      #平均順位を算出
      @average_rank = get_average_rank(count_array, total_game_count)
    end

    def change_uma(uma)
      uma_split = uma.split("-")
      uma1 = uma_split[1].to_i * 1000
      uma2 = uma_split[0].to_i * 1000
      uma3 = uma_split[0].to_i * -1000
      uma4 = uma_split[1].to_i * -1000

      uma_int_array = [uma1,uma2,uma3,uma4]
      return uma_int_array
    end

    def get_average_rank(count_array, total_game_count)
      average_rank = 
      (count_array[0].to_i*1+
      count_array[1].to_i*2+
      count_array[2].to_i*3+
      count_array[3].to_i*4).fdiv(total_game_count)
      return average_rank
    end


    #平均収支を算出するメソッド
    def get_average_income(score_array, count_array, uma_int_array, genten, kaesiten)
      uma1 = uma.split("-")


    end

  end
  