namespace :example do

    desc 'Give Summoner Name and create player with RiotID and SummonerName - Working'
    task :my_task2, [:summ] => :environment do |t,args|
        #include Foo
        sess = Patron::Session.new
        baseURL = 'https://na.api.pvp.net/api/lol/na/v1.4/summoner/by-name/'
        response = args.summ
        closeURL = '?api_key=431e3bd3-93b6-4c50-bf07-983fe86c6414'    
        s = baseURL + response + closeURL

        puts s
        resp = sess.get(s)

        puts resp.body

        hash = JSON.parse resp.body
        rid = hash[response]['id']
        puts rid
        #At this point, we have their riotID
        
        @current_player = Player.create(riotID:rid, name: args.summ)
    end
    
    desc "HTML Player Update"
    task :update_values => :environment do
        player_update = Player.find(ENV["MAILING_ID"])
        player_update.updatePlayer
    end
    
    task :get_last_game_byID, [:sid] => :environment do |t,args|
        summoner = args.sid
        @current_player = Player.find_by(riotID:summoner)
        
        #Debug to see which player is found
        #puts @current_player.name
        
        #Go out and get the JSON data
        sess = Patron::Session.new
        baseURL = 'https://na.api.pvp.net/api/lol/na/v1.3/game/by-summoner/'
        response = summoner
        closeURL = '/recent?api_key=431e3bd3-93b6-4c50-bf07-983fe86c6414'  
        s = baseURL + response + closeURL
        
        resp = sess.get(s)

        hash = JSON.parse resp.body
        #Now we need to look at stats
        
#        var = hash['games']
#        var2 = hash['games'][1]
#        var3 = hash['games'][1]['stats']
        @newk = hash["games"][0]["stats"]["championsKilled"]
        @newd = hash['games'][0]['stats']['numDeaths']
        @newa = hash['games'][0]['stats']['assists']

        if @newk == nil
            @newk = 0
        end
        if @newd == nil
            @newd = 0
        end
        if @newa == nil
            @newa = 0
        end

        var_update_kda
        #Rake example::update_kda_byID[summoner,newk,newd,newa]
    end
    
    #This method will update without using a separate task
    def var_update_kda
        #       To check for starting values
        #        puts @current_player.k.to_i
        
        sumk = @current_player.k.to_i + @newk
        #puts sumk
        sumd = @current_player.d.to_i + @newd
        #puts sumd
        suma = @current_player.a.to_i + @newa
        #puts suma
        @current_player.update(k:sumk)
        @current_player.update(d:sumd)
        @current_player.update(a:suma)
    end
    
    
    desc 'Give Summoner ID and update player KDA - Working'
    task :update_kda_byID, [:sid, :kn, :dn, :an] => :environment do |t,args|
        summoner = args.sid
        @current_player = Player.find_by(riotID:summoner)
        
        @newk = args.kn.to_i
        @newd = args.dn.to_i
        @newa = args.an.to_i
        
        var_update_kda
    end
    
    desc 'Give Summoner Name and update player KDA - Working'
    task :update_kda_byName, [:sid, :kn, :dn, :an] => :environment do |t,args|
        summoner = args.sid
        @current_player = Player.find_by(name:summoner)
        
        @newk = args.kn.to_i
        @newd = args.dn.to_i
        @newa = args.an.to_i
        
        var_update_kda
    end
end