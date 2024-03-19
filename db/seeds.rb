# db/seeds.rb

if Rails.env.development?
  AdminUser.find_or_create_by!(email: 'admin@example.com') do |admin|
    admin.password = 'password'
    admin.password_confirmation = 'password'
  end
end

StaticPage.create(
  title: 'About Us',
  identifier: 'about_us',
  content: <<-HTML
    <h2>Naian Bearings</h2>
    <p>At Naian Bearing, we pride ourselves on being a leading manufacturer and distributor of high-quality bearings, serving diverse industries with excellence since 2006. Our unwavering commitment to precision engineering, top-notch materials, and exceptional customer service has made us a trusted partner for businesses worldwide.</p>
  HTML
)

StaticPage.create(
  title: 'Contact Us',
  identifier: 'contact',
  content: <<-HTML
    <h2>Contact Naian Bearings</h2>
    <p>We welcome your inquiries and feedback. Below is our contact information: </p>
    <ul>
      <li><strong>Address:</strong>300 Assiniboine AVE, Winnipeg, MB, R3C0T1</li>
      <li><strong>Phone Number</strong>+1-234-567-8901</li>
      <li><strong>Email Address</strong><a href="mailto:info@naianbearings.com">info@naianbearings.com</a></li>
    </ul>
  HTML
)