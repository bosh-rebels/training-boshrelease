require 'bosh/template/test'

describe "nginx job" do
  let(:release) { Bosh::Template::Test::ReleaseDir.new(File.join(File.dirname(__FILE__), '..')) }
  let(:job) { release.job('nginx') }

  describe "nginx.conf" do
    let(:template) { job.template('etc/nginx.conf') }

    it "renders by default" do
      expect { template.render({}) }.not_to raise_error
    end

    it "sets the default values" do
      expect( template.render({})).to match(/listen\s+80;/)
      expect( template.render({})).to match(/server_name\s+my\.bosh\.com;/)
    end

    it "sets the port" do
      expect( template.render('port' => 8080)).to match(/listen\s+8080;/)
    end

    it "sets the address" do
      spec = Bosh::Template::Test::InstanceSpec.new(address: 'mynginx.org', bootstrap: true)
      expect(template.render({}, spec: spec)).to match(/server_name\s+mynginx.org;/)
    end
  end
end