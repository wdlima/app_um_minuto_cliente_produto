namespace :curso_data do
  desc "Atualiza data dos cursos"
  task faca: :environment do
  	Curso.all.each do |curso|
  		# if curso.data_inicial.blank?
  		# 	curso.data_inicial = 1.year.ago
  		# end

  		# if curso.data_final.blank?
  		# 	curso.data_final = 1.year.from_now
  		# end

      if curso.data_inicio_curso.blank?
        curso.data_inicio_curso = 1.day.ago
      end

  		curso.save!
  		puts "."
  	end
  end


  desc "Atualiza data expiração curso"
  task data_expiracao_curso: :environment do
    emails = [
      'adalberto.jnr@hotmail.com',
      'adanielbrito@hotmail.com',
      'alaislovera@hotmail.com',
      'alansc.91@hotmail.com',
      'alex10_arza@hotmail.com',
      'alexander_marinho@hotmail.com',
      'alextercioti@gmail.com',
      'anali.anita@gmail.com',
      'anapaula.araujo72@gmail.com',
      'deapersonal@hotmail.com',
      'andreyadesouza@gmail.com',
      'tonepagotti@hotmail.com',
      'antoniomaccelo@hotmail.com',
      'barbarabasquete@hotmail.com',
      'bc.educaf16@gmail.com',
      'carinalopesfisio@gmail.com  ',
      'carolinem93@gmail.com',
      'cassia_bergamaschi@hotmail.com',
      'cwpersonaltrainer@gmail.com',
      'santos.dnl@hotmail.com',
      'davidcavalcante99@hotmail.com',
      'deborapva26@gmail.com',
      'dhiegoadmk@hotmail.com',
      'diego.rambaldi.dr@gmail.com',
      'ederantonucci@gmail.com',
      'elizangelamatias@hotmail.com ',
      'eliziafrm@yahoo.com.br',
      'ernanigs@hotmail.com',
      'evaristo.fontana@yahoo.com.br',
      'ewerson_4@yahoo.com.br',
      'farasje@gmail.com  ',
      'fepersonalingrid@gmail.com',
      'francielyleao@hotmail.com',
      'donfacb@outlook.com',
      'gipenedo@hotmail.com',
      'greylemes@hotmail.com',
      'cngrisi@gmail.com',
      'henriqmarqs@gmail.com',
      'humbertokossmann@gmail.com',
      'ivan.souza3@gmail.com',
      'martinsjackson07@gmail.com',
      'jefferson.oliveirads@hotmail.com',
      'jefferson_v.m@hotmail.com',
      'jehsanti.js@gmail.com',
      'jhp-personal@hotmail.com',
      'jrvs2013@gmail.com',
      'jonas.ribeiro.bs@gmail.com',
      'ktimsampaio@gmail.com',
      'treinamento.fisico@hotmail.com',
      'julimar1800@hotmail.com',
      'duarteju@outlook.com',
      'kellyacaoeagua@gmail.com',
      'kleber.p.trainer@gmail.com',
      'laerthm@hotmail.com',
      'lazaro.ramos237@gmail.com',
      'leandroaparecidopretodegodoi5@gmail.com',
      'lucas.prepara@hotmail.com',
      'luizpaulocoelho77@gmail.com',
      'luci_ufmt@hotmail.com',
      'maillamoraes17@gmail.com',
      'manuraimann@hotmail.com',
      'bombatche@hotmail.com',
      'mdppower@gmail.com',
      'mdouglasborges10@hotmail.com',
      'marcosjosedas@yahoo.com.br',
      'maluleite2@gmail.com  ',
      'marianarmp@hotmail.com  ',
      'mateusceo@gmail.com',
      'mayara.mmassessoriacerimonial@hotmail.com',
      'mayke_m3@yahoo.com.br',
      'milenadias1978@yahoo.com.br',
      'natcouu@yahoo.com.br',
      'patydracena@hotmail.com',
      'ginanjos@yahoo.com.br',
      'pauloh_personaltrainer@hotmail.com',
      'pedrin_leitao@hotmail.com',
      'renatomartinsed.fisica@gmail.com',
      'ricardoalencastro2@hotmail.com',
      'rodolphorleal@hotmail.com',
      'rodrigocrivellarodiasdacosta@gmail.com',
      'rodrigofuncional@hotmail.com',
      'rodrigoperez13590@gmail.com',
      'rutepaula1@hotmail.com',
      'sre.portela20@gmail.com',
      'tiao-tiaozinho@hotmail.com',
      'feme_fitness@hotmail.com',
      'tatianesalatiel70@gmail.com',
      'thayllapersonaltrainer@hotmail.com  ',
      'thiagopele@hotmail.com',
      'tbiker_pr@hotmail.com',
      'cardiofitness.angra@hotmail.com',
      'valkirias2986@gmail.com',
      'fvanessarruda@gmail.com',
      'vanilso_16@hotmail.com',
      'veronicasodre.personal@gmail.com',
      'wgsdutra@hotmail.com',
      'wirke_santos@hotmail.com',
      'yurimarrapersonal@gmail.com'
    ]

    emails.each do |email|
      aluno = Aluno.where(email:email).first
      curso = aluno.aluno_cursos.select{|c|c.id=3}.first rescue nil
      if curso.present?
        data_expiracao = curso.created_at + curso.curso.meses_expiracao.months
        curso.data_expiracao = data_expiracao
        puts "::::::#{aluno.email} - #{curso.data_expiracao.strftime("%d/%m/%Y")}::::::"
      end
    end
  end


  desc "Verifica PagSeguro"
  task verifica_pagseguro: :environment do


    require 'httparty'
    token = "465BD224B53B4D3DAF73672333A628B3"
    data_inicio = "2018-04-01T00:00"
    data_final = "2018-04-22T23:59"
    email_personal = "rodrigo.assi14@gmail.com"
    url = "https://ws.pagseguro.uol.com.br/v2/transactions?initialDate=#{data_inicio}&finalDate=#{data_final}&email=#{email_personal}&token=#{token}"
    
    puts "==============="
    puts url
    puts "==============="

    request = HTTParty.get(URI.escape(url))

    if request["transactionSearchResult"].present?
      if request["transactionSearchResult"]["transactions"].present?
        if request["transactionSearchResult"]["transactions"]["transaction"].present?
          if request["transactionSearchResult"]["transactions"]["transaction"].size > 0
            transactions = request["transactionSearchResult"]["transactions"]["transaction"]
            transactions.each do |transaction|
              url = "https://ws.pagseguro.uol.com.br/v2/transactions/#{transaction["code"]}?email=#{email_personal}&token=#{token}"
              request_transaction = HTTParty.get(URI.escape(url))
              if request_transaction.present? && request_transaction["transaction"].present?

                trans = request_transaction["transaction"]
                email = trans["sender"]["email"]
                nome = trans["sender"]["name"]

                puts "#{nome.strip.downcase} - #{email.strip.downcase}"

                if email.strip.downcase == "jocelima15@hotmail.com"
                  debugger
                  x = ""
                end
              end
            end
          end
        end
      end
    end


  end
end
