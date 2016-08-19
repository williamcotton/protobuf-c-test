const test = require('tape')
const exec = require('child_process').exec

const host = process.env.AMQP_HOST || 'localhost'
const port = '5672'

const amqp = require('amqp')

test('amqp_sendstring', function (t) {
  const connection = amqp.createConnection({host, port})
  const exchangeName = 'testExchangeName'
  const routingkey = 'testRoutingKey'
  const messagebody = 'testMessage'
  connection.on('ready', () => {
    connection.exchange(exchangeName, {}, (exchange) => {
      connection.queue('testQueue', function (q) {
        q.bind(exchangeName, '#', () => {
          q.subscribe(function ({data}) {
            const message = new Buffer(data).toString()
            t.equal(messagebody, message, 'messagebody matches')
            connection.destroy()
            t.end()
          })
          exec(`./build/amqp_sendstring ${host} ${port} ${exchangeName} ${routingkey} ${messagebody}`)
        })
      })
    })
  })
})

test('amqp_producer', function (t) {
  const connection = amqp.createConnection({host, port})
  const messagesToSend = 2
  t.plan(messagesToSend)
  exec(`./build/amqp_producer ${host} ${port} 1 ${messagesToSend}`, (err, stdout, stderr) => {
    if (err) { }
    connection.destroy()
    t.end()
  })
  connection.on('ready', function () {
    connection.queue('test queue', function (q) {
      q.bind('#')
      q.subscribe((message) => {
        t.ok(message.data)
      })
    })
  })
})
