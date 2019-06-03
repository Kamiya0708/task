class TaskMailer < ApplicationMailer
  def creation_email(task)
    @task = task
    mail(
        subject: 'タスク登録完了メール',
        to: 'user@example.com',
        from: 'taskapp@test.mail'
    )
  end
end
