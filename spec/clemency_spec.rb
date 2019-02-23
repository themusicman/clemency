RSpec.describe Clemency do
  it "has a version number" do
    expect(Clemency::VERSION).not_to be nil
  end

  describe ".latest_release" do

    it "should return the latest release" do
      Clemency.define_release do
        set :version, '1.0.0'
      end
      Clemency.define_release do
        set :version, '1.1.0'
      end
      expect(Clemency.latest_release.get(:version)).to eq('1.1.0')
    end

  end

  describe ".define_release" do

    it "allows you to set the version of the release" do
      Clemency.define_release do
        set :version, '1.0.0'
      end
      expect(Clemency.releases).to have_key('1.0.0')
      expect(Clemency.releases['1.0.0'].get(:version)).to eq('1.0.0')
    end

    it "allows you to build a changelog for a release" do
      Clemency.define_release do
        set :version, '1.0.0'
        changelog do
          fixed "Bug in parser"
          added "New feature"
          changed "User sign-up"
        end
      end
      expect(Clemency.releases).to have_key('1.0.0')
      expect(Clemency.releases['1.0.0'].changelog.items.fetch(:fixed).first).to eq("Bug in parser")
      expect(Clemency.releases['1.0.0'].changelog.items.fetch(:added).first).to eq("New feature")
      expect(Clemency.releases['1.0.0'].changelog.items.fetch(:changed).first).to eq("User sign-up")
    end

  end

  describe ".configure" do

    it "allows you to configure Clemency" do
      release = double("release")
      before_up = double("before_up")
      expect(before_up).to receive(:call)
      after_up = double("after_up")
      expect(after_up).to receive(:call)
      Clemency.configure do
        before_up do |release|
          before_up.call
        end
        after_up do |release|
          after_up.call
        end
      end
      Clemency.config.call!(:before_up, release)
      Clemency.config.call!(:after_up, release)
    end

  end


  describe ".migrate!" do

      it "runs all migration callbacks for a release" do

      before_up = double("before_up")
      expect(before_up).to receive(:call)
      after_up = double("after_up")
      expect(after_up).to receive(:call)

      Clemency.configure do
        before_up do |release|
          before_up.call
        end
        after_up do |release|
          after_up.call
        end
      end

      up = double("up")
      expect(up).to receive(:call)

      Clemency.define_release do
        set :version, '1.0.0'
        changelog do
          fixed "Bug in parser"
          added "New feature"
          changed "User sign-up"
        end
        up do |release|
          up.call
        end
      end

      Clemency.migrate!("1.0.0")
    end

  end

  describe ".rollback!" do

    it "runs all rollback callbacks for a release" do

      before_down = double("before_down")
      expect(before_down).to receive(:call)
      after_down = double("after_down")
      expect(after_down).to receive(:call)

      Clemency.configure do
        before_down do |release|
          before_down.call
        end
        after_down do |release|
          after_down.call
        end
      end

      down = double("down")
      expect(down).to receive(:call)

      Clemency.define_release do
        set :version, '1.0.0'
        changelog do
          fixed "Bug in parser"
          added "New feature"
          changed "User sign-up"
        end
        down do |release|
          down.call
        end
      end

      Clemency.rollback!("1.0.0")
    end

  end


end
