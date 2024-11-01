type payment = PaypalPayment(Paypal.payment) | AydenPayment(Ayden.payment) | MonzoPayment(Monzo.payment)

let create_random_payment = (): payment => {
  switch Js.Math.random_int(0, 2) {
    | 0 => PaypalPayment({
      account_id: "123",
      amount: 100,
      currency: ["USD", "EUR", "GBP"][Js.Math.random_int(0, 2)] -> Option.getOr(_, "USD"),
    })
    | 1 => AydenPayment({
      ayden_customer_id: "123",
      amount: 100,
    })
    | _ => MonzoPayment({
      account_id: "123",
      amount: 100,
  })
  }
}

let process_payment = async (payment: payment) => {
  switch payment {
    | PaypalPayment(payment) => {
        await Paypal.process_payment(payment);
    }
    | AydenPayment(payment) => {
        await Ayden.process_payment(payment);
    }
    | MonzoPayment(payment) => {
        await Monzo.process_payment(payment);
    }
  }
}

let main = async () => {
  Array.fromInitializer(~length=10, _ => create_random_payment())
  -> Array.map(_, process_payment)
  -> Js.Promise.all;
}

main() -> ignore
