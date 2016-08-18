const test = require('tape')
const exec = require('child_process').exec

test('amessage_serialize piped to amessage_deserialize', function (t) {
  exec('./build/amessage_serialize 10 2 | ./build/amessage_deserialize', (err, stdout, stderr) => {
    if (err) {}
    t.equal(stdout, 'Received: a=10  b=2\n', 'stdout matches')
    t.end()
  })
})
