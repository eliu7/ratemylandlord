#Text model
class Text < ActiveRecord::Base
  def self.contact
    where(:name => 'contact').first_or_create! do |text|
      text.name = 'contact'
      text.text = 
        "<h2>Contact Us</h2>\n" +
        "<p>\n" +
        "  Please feel free to contact us with any questions, " +
        "  comments, concerns, or suggestions \n" +
        "  at any of the emails listed below. Thank you.\n" +
        "  <br>\n" +
        "  <br>\n" +
        "  Off Campus College Council:\n" +
        "  <br>\n" +
        "  <a href=\"mailto:oc3@binghamtonsa.org\">oc3@binghamtonsa.org</a>\n" +
        "  <br>\n" +
        "  <br>\n" +
        "  SA Webmaster:\n" +
        "  <br>\n" +
        "  <a href=\"mailto:webmaster@binghamtonsa.org\">webmaster@binghamtonsa.org</a>\n" +
        "  <br>\n" +
        "  <br>\n" +
        "  <br>\n" +
        "<p>"
    end
  end
  def self.about
    where(:name => 'about').first_or_create! do |text|
      text.name = 'about'
      text.text = 
        "<h2>About This Site</h2>\n" +
        "<p>\n" +
        "  This is the official Rate my Landlord site for Binghamton University students.\n" +
        "  This site is run by both the Off Campus College and the Off Campus College Council.\n" +
        "  It is provided as a free tool for all" +
        "  Binghamton Students to make living off campus easier\n" +
        "  by giving students a chance to share their experiences with others.\n" +
        "  We feel this site will make moving off campus a more pleasant experience" +
        "  for students by allowing them to understand\nwhat their experience will be like.\n" +
        "</p>\n" +
        "<p>\n" +
        "  Your Binghamton email is all you need to write reviews. " +
        "  Login is done through Google with your @binghamton.edu email. \n" +
        "  All reviews are completely anonymous - we will never disclose your name " +
        "  or any other information to anyone.\n" +
        "</p>\n" +
        "<p>\n" +
        "  If you have any questions, comments or concerns please feel free to contact us. \n" +
        "  We are always willing to hear your feedback!\n" +
        "</p>"
    end
  end
end
