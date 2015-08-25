testsToComplete = 4
tests = []
failures = []
passes = []
pending = []

fs = Npm.require('fs')

onComplete = (aggregateReport) ->
  testReports = VelocityTestReports.find(framework: aggregateReport.name).fetch()
  for rawTestReport in testReports
    testReport =
      title: rawTestReport.name
      fullTitle: rawTestReport.framework + ' - ' + rawTestReport.ancestors.join(' » ')
      duration: rawTestReport.duration
    testReport.error = rawTestReport.failureMessage if rawTestReport.failureMessage?

    tests.push testReport
    failures.push testReport if rawTestReport.result is 'failed'
    passes.push testReport if rawTestReport.result is 'passed'
    pending.push testReport if rawTestReport.pending

  if --testsToComplete is 0
    obj =
      stats:
        suites: 0
        tests: tests.length
        passes: passes.length
        failures: failures.length
        pending: pending.length
        duration: _.reduce(tests, ((memo, test) -> memo + test.duration), 0)
      failures: failures
      passes: passes
      skipped: []
    fs.writeFileSync('../../../../../bamboo.json', JSON.stringify(obj, null, 2), 'utf-8');

VelocityAggregateReports.remove {}
VelocityAggregateReports.find(
  name: $nin: [
    'aggregateResult'
    'aggregateComplete'
  ]
  result: 'completed').observe added: onComplete