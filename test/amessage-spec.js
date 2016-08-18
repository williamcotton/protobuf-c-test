const test = require('tape')
const exec = require('child_process').exec

test('1-1-hello', function (t) {
  exec('./build/amessage_serialize 10 2 | ./build/amessage_deserialize', (err, stdout, stderr) => {
    if (err) {}
    t.equal(stdout, 'Received: a=10  b=2\n', 'stdout matches')
    t.end()
  })
})
