import 'package:hive/hive.dart';
import 'package:proequine/features/home/data/local_trip.dart';

import '../../../../../core/CoreModels/base_local_storage_repository.dart';
import '../../../../core/utils/Printer.dart';

class LocalStorageRepository extends BaseLocalStorageRepository {
  String boxName = '1232';
  String idsBoxName = 'horse';

  /// Method to create auction

  // @override
  // Future<void> addAuctionIds(String id) async {
  //   Box box = await Hive.openBox<String>(idsBoxName);
  //   await box.put(id, id);
  // }
  //
  // /// Method to delete all of the auctions
  // @override
  // Future<void> clearAuctions(Box<dynamic> box) async {
  //   await box.clear();
  // }
  //
  // /// Method to delete a specific auction
  // @override
  // Future<void> deleteAuction(Box box, Auction item) async {
  //   await box.delete(item.id);
  // }
  //
  // @override
  // Future<void> deleteAuctionIds(String id) async {
  //   Box box = await Hive.openBox<String>(idsBoxName);
  //   await box.delete(id);
  // }
  //

  //
  // /// Method to get the lots inside a specific auction

  // /// open the ids box
  // @override
  // Future<Box> openAuctionIdsBox() async {
  //   Box box = await Hive.openBox<int>(idsBoxName);
  //   return box;
  // }
  //
  // /// open the auctions box
  @override
  Future<Box> openBox() async {
    Box box = await Hive.openBox<Trip>(boxName);
    return box;
  }

  @override
  Future<void> addHorseToTrip(String tripId, Horse horse) async {
    Box box = await Hive.openBox<Trip>(boxName);
    Trip? trip = box.get(tripId);

    if (trip != null) {
      trip.horses.add(horse);
      await box.put(tripId, trip);
    }
  }

  @override
  Future<Trip?> getSpecificTrip(String tripId) async {
    Box<Trip> box = await Hive.openBox<Trip>(boxName);
    Trip? trip = box.get(tripId);

    return trip;
  }


  @override
  Future<void> deleteTrip(Box box, Trip item) async {
    await box.delete(item.tripId);

  }

  @override
  Future<void> createTrip(Box<dynamic> box, Trip item) async {
    await box.put(item.tripId, item);
  }

  @override
  Future<void> editSpecificHorse(
      String tripId, String horseId, Horse updateHorse) async {
    final box = await Hive.openBox<Trip>(
        boxName); // Open the Hive box for 'auctions'

    final trip = box.values.cast<Trip>().firstWhere(
          (a) => a.tripId == tripId,
        );
    if (trip != null) {
      final horse = trip.horses.firstWhere(
        (l) => l.horseId == horseId,
      );
      if (horse != null) {

        horse.staying = updateHorse.staying; // Update the lot properties as needed
        horse.ownership = updateHorse.ownership;
        horse.yearOfBirth = updateHorse.yearOfBirth;
        horse.color = updateHorse.color;
        horse.breed = updateHorse.breed;
        horse.bloodline = updateHorse.bloodline;
        horse.gender = updateHorse.gender;
        horse.discipline = updateHorse.discipline;
        horse.horseName=updateHorse.horseName;
        await box.put(trip.key, trip); // Update the auction in Hive
        Print(
            'Lot with ID $horseId in auction with ID $tripId successfully updated.');
      } else {
        Print('Lot with ID $horseId not found in auction with ID $tripId.');
      }
    } else {
      Print('Auction with ID $tripId not found in Hive.');
    }

    await box.close(); // Close the Hive box
  }

  @override
  Future<void> editSpecificTrip(
      String tripId, Trip updateTrip) async {
    final box = await Hive.openBox<Trip>(
        boxName); // Open the Hive box for 'auctions'

    final trip = box.values.cast<Trip>().firstWhere(
          (a) => a.tripId == tripId,
    );
    if (trip != null) {
      trip.dropContactName=updateTrip.dropContactName;
      trip.dropLocation=updateTrip.dropLocation;
      trip.dropCountryCode=updateTrip.dropCountryCode;
      trip.pickupLocation=updateTrip.pickupLocation;
      trip.exportingCountry=updateTrip.exportingCountry;
      trip.importingCountry=updateTrip.importingCountry;
      trip.equipmentTask=updateTrip.equipmentTask;
      trip.dropPhoneNumber=updateTrip.dropPhoneNumber;
      trip.pickupCountryCode=updateTrip.pickupCountryCode;
      trip.pickupContactName=updateTrip.pickupContactName;
      trip.pickupPhoneNumber=updateTrip.pickupPhoneNumber;
      trip.numberOfHorses=updateTrip.numberOfHorses;
      trip.shippingEstimatedDate=updateTrip.shippingEstimatedDate;

      await box.put(trip.key, trip);

    }

    await box.close(); // Close the Hive box
  }

  /// Method to get the horses inside a specific trip
  List<Horse> getHorses(String tripId) {
    Box box = Hive.box<Trip>(boxName);
    Trip? trip = box.get(tripId);
    return trip?.horses ?? [];
  }

  @override
  List<Trip> getAllTrips(Box box) {
    return box.values.toList() as List<Trip>;
  }

//
// /// method to create lot inside the auction
// @override
// Future<void> addLotToAuction(String auctionId, Lot lot) async {
//   Box box = await Hive.openBox<Auction>(boxName);
//   Auction? auction = box.get(auctionId);
//
//   if (auction != null) {
//     auction.lots.add(lot);
//     await box.put(auctionId, auction);
//   }
// }
//
// @override
// Future<void> editSpecificLot(String auctionId, String lotId, Lot updatedLot) async {
//   final box = await Hive.openBox<Auction>(boxName); // Open the Hive box for 'auctions'
//
//   final auction = box.values.cast<Auction>().firstWhere((a) => a.id == auctionId,);
//   if (auction != null) {
//     final lot = auction.lots.firstWhere((l) => l.id == lotId,);
//     if (lot != null) {
//       lot.productsCount = updatedLot.productsCount; // Update the lot properties as needed
//       lot.lotPrice = updatedLot.lotPrice;
//       // Update other properties accordingly
//
//       await box.put(auction.key, auction); // Update the auction in Hive
//       Print('Lot with ID $lotId in auction with ID $auctionId successfully updated.');
//     } else {
//       Print('Lot with ID $lotId not found in auction with ID $auctionId.');
//     }
//   } else {
//     Print('Auction with ID $auctionId not found in Hive.');
//   }
//
//   await box.close(); // Close the Hive box
// }
//
// /// method to delete the lot from the auction
// @override
// Future<void> deleteLotFromAuction(String auctionId, String lotId) async {
//   Box box = await Hive.openBox<Auction>(boxName);
//   Auction? auction = box.get(auctionId);
//
//   if (auction != null) {
//     auction.lots.removeWhere((lot) => lot.id == lotId);
//     await box.put(auctionId, auction);
//   }
// }
//
// /// Method to get the products from a specific lot
// @override
// List<Product> getProducts(String auctionId, String lotId) {
//   Box box = Hive.box<Auction>(boxName);
//   Auction? auction = box.get(auctionId);
//
//   if (auction != null) {
//     Lot? lot = auction.lots
//         .firstWhere((lot) => lot.id == lotId, orElse: () => auction.lots[0]);
//     if (lot != null) {
//       return lot.products;
//     }
//   }
//
//   return [];
// }
//
// /// method to create a product inside a specific lot
// @override
// Future<void> addProduct(
//     String auctionId, String lotId, Product product) async {
//   Box box = await Hive.openBox<Auction>(boxName);
//   Auction? auction = box.get(auctionId);
//
//   if (auction != null) {
//     Lot? lot = auction.lots
//         .firstWhere((lot) => lot.id == lotId, orElse: () => auction.lots[0]);
//     Print("lot id $lotId");
//     Print("lot id.. ${lot.id}");
//
//     if (lot.id != null) {
//       lot.products.add(product);
//       Print(lot.products);
//
//       await box.put(auctionId, auction);
//     }
//   }
// }
//
// /// method to delete a product from a specific lot
// @override
// Future<void> deleteProduct(
//     String auctionId, String lotId, String productId) async {
//   Box box = await Hive.openBox<Auction>(boxName);
//   Auction? auction = box.get(auctionId);
//
//   if (auction != null) {
//     Lot? lot = auction.lots
//         .firstWhere((lot) => lot.id == lotId, orElse: () => auction.lots[0]);
//
//     if (lot != null) {
//       lot.products.removeWhere((product) => product.id == productId);
//       await box.put(auctionId, auction);
//     }
//   }
// }
}
