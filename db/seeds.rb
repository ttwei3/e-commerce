# db/seeds.rb

if Rails.env.development?
  AdminUser.find_or_create_by!(email: 'admin@example.com') do |admin|
    admin.password = 'password'
    admin.password_confirmation = 'password'
  end
end

StaticPage.find_or_create_by!(title: 'About Us', identifier: 'about_us') do |page|
  page.content = <<-HTML
    <h2>Naian Bearings</h2>
    <p>At Naian Bearing, we pride ourselves on being a leading manufacturer and distributor of high-quality bearings, serving diverse industries with excellence since 2006. Our unwavering commitment to precision engineering, top-notch materials, and exceptional customer service has made us a trusted partner for businesses worldwide.</p>
  HTML
end

StaticPage.find_or_create_by!(title: 'Contact Us', identifier: 'contact') do |page|
  page.content = <<-HTML
    <h2>Contact Naian Bearings</h2>
    <p>We welcome your inquiries and feedback. Below is our contact information: </p>
    <ul>
      <li><strong>Address:</strong>300 Assiniboine AVE, Winnipeg, MB, R3C0T1</li>
      <li><strong>Phone Number:</strong>+1-234-567-8901</li>
      <li><strong>Email Address:</strong><a href="mailto:info@naianbearings.com">info@naianbearings.com</a></li>
    </ul>
  HTML
end

provinces_tax_rates = [
  { name: 'AB - Alberta', gst: 0.05, pst: 0.0, hst: 0.0 },
  { name: 'BC - British Columbia', gst: 0.05, pst: 0.07, hst: 0.0 },
  { name: 'MB - Manitoba', gst: 0.05, pst: 0.07, hst: 0.0 },
  { name: 'NB - New Brunswick', gst: 0.0, pst: 0.0, hst: 0.15 },
  { name: 'NL - Newfoundland and Labrador', gst: 0.0, pst: 0.0, hst: 0.15 },
  { name: 'NS - Nova Scotia', gst: 0.0, pst: 0.0, hst: 0.15 },
  { name: 'NT - Northwest Territories', gst: 0.05, pst: 0.0, hst: 0.0 },
  { name: 'NU - Nunavut', gst: 0.05, pst: 0.0, hst: 0.0 },
  { name: 'ON - Ontario', gst: 0.0, pst: 0.0, hst: 0.13 },
  { name: 'PE - Prince Edward Island', gst: 0.0, pst: 0.0, hst: 0.15 },
  { name: 'QC - Quebec', gst: 0.05, pst: 0.09975, hst: 0.0 },
  { name: 'SK - Saskatchewan', gst: 0.05, pst: 0.06, hst: 0.0 },
  { name: 'YT - Yukon', gst: 0.05, pst: 0.0, hst: 0.0 }
]

provinces_tax_rates.each do |province_data|
  province = Province.find_or_initialize_by(name: province_data[:name])
  province.gst = province_data[:gst]
  province.pst = province_data[:pst]
  province.hst = province_data[:hst]
  province.save
end

puts "Provinces and their tax rates have been seeded."