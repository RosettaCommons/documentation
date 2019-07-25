#Description

As of RosettaCon 2019, no new filters should be added to Rosetta (with few exceptions)

So - what is replacing them?  SimpleMetrics.  SimpleMetrics are a tool that allows you to calculate some property of a pose, store it, and output the data into a scorefile.  These SimpleMetrics can also be used for filters and FeaturesReporters, greatly expanding their use across Rosetta. 

For a good description of their use, see the [[SM documentation | SimpleMetrics ]]