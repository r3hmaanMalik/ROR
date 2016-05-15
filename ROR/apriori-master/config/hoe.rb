require 'apriori/version'

AUTHOR = 'Nate Murray'  # can also be an array of Authors
EMAIL = "nate@natemurray.com"
DESCRIPTION = "Ruby Apriori is a library to efficiently find item association rules within large sets of transactions."
GEM_NAME = 'apriori' # what ppl will type to install your gem
RUBYFORGE_PROJECT = 'apriori' # The unix name for your project
HOMEPATH = "http://#{RUBYFORGE_PROJECT}.rubyforge.org"
DOWNLOAD_PATH = "http://rubyforge.org/projects/#{RUBYFORGE_PROJECT}"
EXTRA_DEPENDENCIES = [
#  ['activesupport', '>= 1.3.1']
  ['rake', '>= 0.0.0'],
  ['hoe', '>= 0.0.0'], 
  ['newgem', '>= 0.0.0'],
  ['rubigen', '>= 0.0.0']
]    # An array of rubygem dependencies [name, version]

@config_file = "~/.rubyforge/user-config.yml"
@config = nil
RUBYFORGE_USERNAME = "unknown"
def rubyforge_username
  unless @config
    begin
      @config = YAML.load(File.read(File.expand_path(@config_file)))
    rescue
      puts <<-EOS
ERROR: No rubyforge config file found: #{@config_file}
Run 'rubyforge setup' to prepare your env for access to Rubyforge
 - See http://newgem.rubyforge.org/rubyforge.html for more details
      EOS
      exit
    end
  end
  RUBYFORGE_USERNAME.replace @config["username"]
end


REV = nil
# UNCOMMENT IF REQUIRED:
# REV = YAML.load(`svn info`)['Revision']
#VERSION = Apriori::VERSION::STRING + (REV ? ".#{REV}" : "")
RDOC_OPTS = ['--quiet', '--title', 'apriori documentation',
    "--opname", "index.html",
    "--line-numbers",
    # "--exclude=ext",
    "--main", "README",
    "--inline-source"]

class Hoe
  def extra_deps
    @extra_deps.reject! { |x| Array(x).first == 'hoe' }
    @extra_deps
  end
end

# Generate all the Rake tasks
# Run 'rake -T' to see list of generated tasks (from gem root directory)
$hoe = Hoe.spec GEM_NAME do
  self.developer(AUTHOR, EMAIL)
  self.description = DESCRIPTION
  self.summary = DESCRIPTION
  self.url = HOMEPATH
  self.rubyforge_name = RUBYFORGE_PROJECT if RUBYFORGE_PROJECT
  self.test_globs = ["test/**/test_*.rb"]
  self.clean_globs |= ['**/.*.sw?', '*.gem', '.config', '**/.DS_Store']  #An array of file patterns to delete on clean.
  self.extra_rdoc_files = ["test/fixtures/market_basket_results_test.txt", "test/fixtures/market_basket_string_test.txt", "test/fixtures/results.txt", "test/fixtures/sample.txt"]

  # self.spec_extras = {:extensions, FileList["ext/**/extconf.rb"].to_a} # A hash of extra values to set in the gemspec.
  self.spec_extras = {:extensions, 'Rakefile'} # A hash of extra values to set in the gemspec.

  # == Optional
  self.changes = self.paragraphs_of("History.txt", 0..1).join("\n\n")
  self.extra_deps = EXTRA_DEPENDENCIES

  end

CHANGES = $hoe.paragraphs_of('History.txt', 0..1).join("\\n\\n")
PATH    = (RUBYFORGE_PROJECT == GEM_NAME) ? RUBYFORGE_PROJECT : "#{RUBYFORGE_PROJECT}/#{GEM_NAME}"
$hoe.remote_rdoc_dir = File.join(PATH.gsub(/^#{RUBYFORGE_PROJECT}\/?/,''), 'rdoc')
$hoe.rsync_args = '-av --delete --ignore-errors'
$hoe.spec.post_install_message = File.open(File.dirname(__FILE__) + "/../PostInstall.txt").read rescue ""
