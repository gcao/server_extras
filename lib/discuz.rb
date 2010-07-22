require 'uri'

def login host, username, password  
  url = "http://#{host}/bbs/logging.php"

  post_data = {
    "referer"     => "index.php",
    "action"      => "login",
    "loginsubmit" => "yes",
    "loginfield"  => "username",
    "username"    => username,
    "password"    => password,
    "answer"      => "",
    "cookietime"  => "2592000",
  }.map{ |key, value| "#{key}=#{value}" }.join("&")

  cookie_file = "/tmp/cookie-#{rand(100}.txt"
  cmd = "curl -d \"#{post_data}\" -D #{cookie_file} -o /tmp/cache.html #{url}"
  puts cmd

  `#{cmd}`
  puts cookie_file
  cookie_file
end

def get_form_hash host, fid, cookie_file
  url        = "http://#{host}/bbs/forumdisplay.php?fid=#{fid}"
  referer    = "http://#{host}/bbs/forumdisplay.php?fid=#{fid}"
  user_agent = "Mozilla/5.0 (Macintosh; U; Intel Mac OS X 10.5; en-US; rv:1.9.1.5) Gecko/20091102 Firefox/3.5.5"

  cmd = %Q(curl -b #{cookie_file} -o /tmp/cache.html -A "#{user_agent}" -e "#{referer}" "#{url}")
  `#{cmd}`

  File.open("/tmp/cache.html") do |file|
    file.each do |line|
      next unless line.index('name="formhash"')
      line =~ /value="([\w\d]+)"/
      return $1
    end
  end
end

def post host, fid, subject, body, cookie_file
  formhash   = get_form_hash host, fid, cookie_file
  
  url        = "http://#{host}/bbs/post.php"
  referer    = "http://#{host}/bbs/forumdisplay.php?fid=#{fid}"

  user_agent = "Mozilla/5.0 (Macintosh; U; Intel Mac OS X 10.5; en-US; rv:1.9.1.5) Gecko/20091102 Firefox/3.5.5"

  post_data = {
    "formhash"      => formhash,
    "action"        => "newthread",
    "topicsubmit"   => "yes",
    "fid"           => fid,
    "subject"       => URI.escape(subject),
    "message"       => URI.escape(body),
    "extra"         => "",
    "wysiwyg"       => "0",
    "iconid"        => "",
    "sortid"        => "0",
    "checkbox"      => "0",
    "tags"          => "",
    "readperm"      => "",
    "attention_add" => "1",
    "usesig"        => "1",
  }.map{ |key, value| "#{key}=#{value}" }.join("&")

  cmd = %Q(curl -d "#{post_data}" -b #{cookie_file} -o /tmp/cache.html -A "#{user_agent}" -e "#{referer}" "#{url}")
  puts cmd

  `#{cmd}`
end
