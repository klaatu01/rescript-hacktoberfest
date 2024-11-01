type payment = {
  account_id: string,
  amount: int,
  currency: string,
}

let sleep = (time: int) => {
  Js.Promise.make((~resolve, ~reject) => {
    let _ = setTimeout((.) => {
      resolve(. ignore())
    }, time)
  })
}

let check_currency = (payment: payment): result<payment, string> => {
  switch payment.currency {
  | "USD" => Ok(payment)
  | _ => Error("Currency not supported")
  }
}

let send_payment = async (payment: payment): promise<payment> => {
  let sleep_time = Js.Math.random_int(1, 5) * 1000
  await sleep(sleep_time)
  Js.Promise.resolve(payment)
}

let process_payment = async (payment: payment) => {
  let payment = check_currency(payment)
  switch payment {
    | Ok(payment) => {
        Js.log("Processing Paypal payment...")
        let done = await payment->send_payment
        done->Js.log
      }
    | Error(error) => Js.log(error)
  }
}
