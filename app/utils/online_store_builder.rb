class OnlineStoreBuilder < AbstractBuilder

  # @job_id avail from parent class

  def initialize
    super
  end

  def build

    ws_name = name('Workspace')
    online_store = name('Online Store')
      consumer_site = name('Consumer Site')
        fulfillment_team = name('Fulfillment Team')
        payment_team = name('Payment Team')
        shopping_team = name ('Shopping Team')
      reseller_site = name('Reseller Site')
        analytics_team = name ('Analytics Team')
        reseller_portal_team = name ('Reseller Portal Team')
      platform = name('Platform')
        api_team = name ('API Team')
      
    workspace({name: ws_name})
    project({name: online_store, workspace: ws_name})
    project({name: consumer_site, parent: online_store, workspace: ws_name })
    project({name: fulfillment_team, parent: consumer_site, workspace: ws_name })
    project({name: payment_team, parent: consumer_site, workspace: ws_name })
    project({name: shopping_team, parent: consumer_site, workspace: ws_name })

    release_dates = {
      "Q1 2015": {releasestartdate: Date.new(2015,01,01), releasedate: Date.new(2015,3,31)},
      "Q2 2015": {releasestartdate: Date.new(2015,04,01), releasedate: Date.new(2015,6,30)},
      "Q3 2015": {releasestartdate: Date.new(2015,07,01), releasedate: Date.new(2015,9,30)},
      "Q4 2015": {releasestartdate: Date.new(2015,10,01), releasedate: Date.new(2015,12,31)},
    }

    @artifact_cache[:project].each do |project|
      release_dates.each_pair do |name, attrs|
        release({name: name, project: project[:name], releasedate: attrs[:releasedate], releasestartdate: attrs[:releasestartdate], state: 'Active'})
      end
    end

    pi_initiative_1_name = 'Minimial online shopping site'
    pi_feature_1_name = 'Shopping Cart'
    pi_feature_2_name = 'Priority Shipping'
    pi_feature_3_name = 'Product Listings'
    pi_feature_4_name = 'Credit card Payments'
    pi_feature_5_name = 'Knowledgebase'

    portfolio_item_initiative({name: pi_initiative_1_name, project: online_store, preliminaryestimate: 'L', refinedestimate: 50})
    portfolio_item_feature({name: pi_feature_1_name, parent: pi_initiative_1_name, project: online_store, preliminaryestimate: 'L', refinedestimate: 50})
    portfolio_item_feature({name: pi_feature_2_name, parent: pi_initiative_1_name, project: online_store, preliminaryestimate: 'XL', refinedestimate: 25})
    portfolio_item_feature({name: pi_feature_3_name, parent: pi_initiative_1_name, project: online_store, preliminaryestimate: 'S', refinedestimate: 50})
    portfolio_item_feature({name: pi_feature_4_name, parent: pi_initiative_1_name, project: online_store, preliminaryestimate: 'S', refinedestimate: 150})
    portfolio_item_feature({name: pi_feature_5_name, parent: pi_initiative_1_name, project: online_store, preliminaryestimate: 'M', refinedestimate: 75})
  end

  private

  def name(name)
    "#{name} #{@job_id}"
  end
end
