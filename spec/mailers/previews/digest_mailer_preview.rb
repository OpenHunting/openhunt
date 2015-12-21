# Preview all emails at http://localhost:3000/rails/mailers/digest_mailer
# to run:
# rails console
# DigestMailer.new.daily_email
# => navigate to http://localhost:3000/rails/mailers/digest_mailer

class DigestMailerPreview < ActionMailer::Preview

  def daily_email
    submitter =FactoryGirl.create(:user)
    list_subscriber = submitter.create_list_subscriber(email: "test@test.com")
    project = submitter.projects.create(FactoryGirl.attributes_for(:project,  bucket: "20151214"))
    contents =
      { "projects" => [ project ] }
    digest = DailyDigest.create(
      sent: false,
      contents: contents,
      bucket: Project.bucket(Time.now - 1.day)
    )
    DigestMailer.daily_email(list_subscriber, digest)
  end
end
