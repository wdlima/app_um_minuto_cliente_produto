Thread.new do
  loop do
    um_minuto = 60
    uma_hora = (um_minuto * 60)
    um_dia = (uma_hora * 24)
    sleep um_dia

    puts "::: Sync alunos certificados :::"
    AlunoCurso.todos_nao_enviado_certificado.each do |ac|
      if Curso.concluido?(ac.curso_id, ac.aluno_id)
        unless ac.certificado_enviado
          a.certificado_enviado = true
          a.save!
          PersonalMailer.enviar_certificado(a).deliver
        end
      end
    end
    puts "::: Sync alunos certificados Done:::"

    puts "::: Sync avisar_alunos_whatsapp :::"
    AlunoCurso.avisar_rodrigo_alunos_remover_whatsapp!
    AlunoCurso.avisar_rodrigo_alunos_entrar_whatsapp!
    AlunoCurso.avisar_alunos_remover_whatsapp!
    AlunoCurso.avisar_alunos_entrar_whatsapp!
    AlunoCurso.envia_emails_curso_a_expirar!
    puts "::: Sync envia_emails_curso_a_expirar Done:::"

  end
end