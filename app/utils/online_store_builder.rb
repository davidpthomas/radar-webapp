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
#    project({name: online_store, workspace: ws_name})
#    project({name: consumer_site, parent: online_store, workspace: ws_name })
#    project({name: fulfillment_team, parent: consumer_site, workspace: ws_name })
#    project({name: payment_team, parent: consumer_site, workspace: ws_name })
#    project({name: shopping_team, parent: consumer_site, workspace: ws_name })

  end

  private

  def name(name)
    "#{name} #{@job_id}"
  end
end
