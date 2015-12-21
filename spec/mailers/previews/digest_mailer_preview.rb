# Preview all emails at http://localhost:3000/rails/mailers/digest_mailer
# to run:
# rails console
# DigestMailerPreview.new.daily_email
# => navigate to http://localhost:3000/rails/mailers/digest_mailer

class DigestMailerPreview < ActionMailer::Preview

  def daily_email
    submitter = FactoryGirl.create(:user)
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

  def weekly_email
    submitter = FactoryGirl.create(:user)
    list_subscriber = submitter.create_list_subscriber(email: "test@test.com")
    project = submitter.projects.create(FactoryGirl.attributes_for(:project,  bucket: "20151214"))
    contents = {
      "buckets" => [
        { "bucket" => 20151208, "projects" => [ project ] },
        { "bucket" => 20151209, "projects" => [ project ] },
        { "bucket" => 20151210, "projects" => [ project ] },
        { "bucket" => 20151211, "projects" => [ project ] },
        { "bucket" => 20151213, "projects" => [ project ] },
        { "bucket" => 20151214, "projects" => [ project ] },
      ]
    }
    digest = WeeklyDigest.create(
      sent: false,
      contents: contents,
      bucket_range: "20151208 20151214"
    )
    DigestMailer.weekly_email(list_subscriber, digest)
  end

end
