#!/usr/bin/ruby

require 'net/imap'
require 'date'
require 'yaml'

def read_config
    config = YAML.load_file("icin_mail.yaml")
    @server = config["config"]["server"]
    @user = config["config"]["user"]
    @pass = config["config"]["password"]
    @folder = config["config"]["folder"]
    @words_to_find = config["config"]["words_to_find"]
    @from = config["config"]["from"]
end

def find_in_email()

    read_config()
    imap = Net::IMAP.new(@server, 993, true)
    imap.login(@user, @pass)
    imap.select(@folder)
    body = ""

    imap.search(["FROM", @from]).each do |msg_id|
        envelope = imap.fetch(msg_id, "ENVELOPE")[0].attr["ENVELOPE"]
        @subject = envelope.subject

        @email_date =DateTime.parse(envelope.date)
        @email_date = Time.new(@email_date.year, @email_date.month, @email_date.day, @email_date.hour, @email_date.min, @email_date.sec, @email_date.zone)
       
        body = imap.fetch(msg_id, "BODY[TEXT]")[0].attr["BODY[TEXT]"]
    end

    imap.logout
    imap.disconnect

    return body
end

def read_email(body)

    success = 0
    failure = 1

    number_failed = 0

    current_time = Time.now
    earliest_time = Time.new(current_time.year, current_time.month, current_time.day, 4, 0)
    latest_time = Time.new(current_time.year, current_time.month, current_time.day, 6, 0)

    current_time = (current_time.utc).to_s
    latest_time = (latest_time.utc).to_s
    earliest_time = (earliest_time.utc).to_s
    @email_date = (@email_date.utc).to_s

   if(@email_date > earliest_time && @email_date < latest_time)
     
        body.each_line do |line|
            for word in @words_to_find
                if ((line.include? word) && (!line.include? "<br>"))     
                    arr = line.split
                    number = (arr.last()).to_i
                    if(word == "Exception")
                        puts line
                        number_failed +=1
                    end
                    if number != 0
                        puts line
                        number_failed +=1
                    end
                end
            end
        end        
    end
    if number_failed !=0
        return failure
    end
    return success
end

var = read_email(find_in_email())
puts var