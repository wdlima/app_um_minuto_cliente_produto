Thread.new do
  loop do
    sleep (60*60) # 1 hora
    # sleep 30 # 30 segundos
    puts "::: PagSeguro Sync - inicio - #{Time.now.strftime("%d/%m/%Y")}:::"
    Aluno.sync_pagseguro(Time.now.strftime("%d/%m/%Y"))
    puts "::: PagSeguro Sync - fim - #{Time.now.strftime("%d/%m/%Y")}:::"
  end
end
