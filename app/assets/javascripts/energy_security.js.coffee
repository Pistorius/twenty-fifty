class EnergySecurity

  constructor: () ->
    @long_descriptions = twentyfifty.longDescriptions
  
  documentReady: () ->
    # Nothing
  
  updateResults: (@pathway) ->
    @updateBalancingSection()
    @updateImportsSection()
    @updatedDiversitySection()
  
  updateBalancingSection: () ->
    element = $('#balancing')
    element.empty()
    element.append("<h2>Balancing electricity supply and demand</h2>")
    if @pathway.electricity.automatically_built > 0
      element.append("<p>#{Math.round(@pathway.electricity.automatically_built)} GW of conventional gas electricity generation plant has been assumed to have been built by 2050, to cover the gap between average electricity demand and the amount of low carbon generation selected in this pathway.</p>")
    element.append("<p>This tool does not model the hourly, daily or even seasonal operation of the electricity grid. It presents annual averages. Therefore it does not correctly represent the need peaks and troughs of electricity demand.<p>")
    element.append("<p>To go some way to addressing this flaw, the tool applies a simulated stress test to your pathway of five cold, almost windless, days.")
    element.append("In this case, the stress test implies that #{Math.round(@pathway.electricity.peaking)} GW of additional peaking plant may be required for supply to meet demand over that period.</p>")
    element.append("<p>You can influence the amount of peaking plant by changing your choice level of 'storage, demand shifting & interconnection' below right, or by reducing the amount of intermittent renewable generation, or by reducing the demand for electricity</p>")
    
  
    #   Conventional power stations are built automatically to fill any shortfall in electricity supply. Coal, Oil and Natural Gas are automatically imported to fill any shortfall in bioenergy.
    # 
    # %p.security_label 
    #   In 2050, #{(@pathway.percent_energy_imported*100).round}% of primary energy will be imported.
    # 
    # 
    # element.append("<p>TBD</p>")

  updateImportsSection: () ->
    element = $('#imports')
    element.empty()
    element.append("<h2>Dependence on imported energy</h2>")
    element.append("<p>The calculator assumes that any available biomass is preferred over fossil fuels and that domestically produced fuels are preferred over imports. It assumes that fossil fuels are imported to cover any shortfall.</p>")
    element.append("<table class='imports'>")
    element.append("<tr><th class='description'>Fuel</th><th class='value'>TWh/yr in 2050</th><th class='value'>% imported</th></tr>")
    for own name, values of @pathway.imports
      element.append("<tr><td class='description'>#{name}</td><td class='value'>#{values.quantity}</td><td class='value'>#{values.proportion}</td></tr>")
    element.append("</table>")

  updatedDiversitySection: () ->
    element = $('#diversity')
    element.empty()
    element.append("<h2>Diversity of sources</h2>")
    totals = @pathway.primary_energy_supply['Total Primary Supply']
    sw = [0,0,0,0,0,0,0,0,0]
    for own form, values of @pathway.primary_energy_supply
      unless form == "Total Primary Supply"
        for value, i in values
          unless value == 0
            share = value / totals[i]
            natural_log_share = Math.log(share)
            console.log share, natural_log_share
            sw[i] += (share * -natural_log_share)
    element.append("<p>TBD - Shannon-Wiener measure</p>")
    element.append("<p>TBD - Higher is better, numbers below buggy?</p>")    
    element.append("<table>")
    element.append("<tr><th class='description'>Year</th><th class='value'>SW</th></tr>")
    for value, i in sw
      element.append("<tr><td class='description'>#{i}</td><td class='value'>#{value}</td></tr>")
    element.append("</table>")

window.twentyfifty.EnergySecurity = EnergySecurity


