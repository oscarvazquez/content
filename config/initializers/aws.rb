s3 = Aws::S3::Resource.new(
  credentials: Aws::Credentials.new(ENV['AWS_ACCESS_KEY_ID'], ENV['AWS_SECRET_ACCESS_KEY']),
  region: 'us-west-1'
)
S3_BUCKET = s3.bucket(ENV['S3_BUCKET'])

# S3_BUCKET.objects.each do |obj|
# #   puts "#{obj.key}"
# #   puts "#{obj.etag}"
# #   puts obj.public_url
# # end

# obj = S3_BUCKET.object('12345/picture')
# obj.upload_file('/Users/oscarvazquez/desktop/bloodgrade1.png', acl:'public-read')
# puts obj.public_url

# test = S3_BUCKET.object("1234/resume")
# # puts test
# # puts test.public_url
