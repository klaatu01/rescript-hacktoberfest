type payment = {
  ayden_customer_id: string,
  amount: int,
}

let sleep = (time: int) => {
  Js.Promise.make((~resolve, ~reject) => {
    let _ = setTimeout((.) => {
      resolve(. ignore())
    }, time)
  })
}

let send_payment = async (payment: payment): promise<payment> => {
  let sleep_time = Js.Math.random_int(1, 5) * 1000
  await sleep(sleep_time)
  Js.Promise.resolve(payment)
}

let process_payment = async (payment: payment) => {
  Js.log("Processing Ayden payment...")
  let done = await payment->send_payment
  done->Js.log
}
