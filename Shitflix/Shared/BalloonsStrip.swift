import UIKit

class BalloonsStrip: UICollectionViewCell, Strip {
    
    static let rID = "balloons-strip"
    
    var movieStrip: MovieStrip? {
        didSet {
            update()
        }
    }
    
    private let label = UILabel()
    private let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        setup()
        style()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setup() {
        layout.scrollDirection = .horizontal
        collectionView.dataSource = self
        collectionView.register(BalloonCell.self,
                                forCellWithReuseIdentifier: BalloonCell.rID)
        
        addSubview(label)
        addSubview(collectionView)
    }
    
    private func style() {
        self.backgroundColor = UIColor(hex: Palette.background)
        
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 15, weight: .heavy)
        
        collectionView.backgroundColor = UIColor(hex: Palette.background)
    }
    
    private func update() {
        label.text = movieStrip?.type.rawValue
        collectionView.reloadData()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        /* size of the whole strip cell */
        let w = self.bounds.width
        let h = self.bounds.height
        
        /* set the layout of the title of the strip cell */
        label.frame = CGRect(x: 10, y: 0, width: w - 20, height: 17)
        
        /* set the layout of the strip of balloons*/
        collectionView.frame = CGRect(x: 0, y: 17, width: w, height: h - 20)
        
        /* set size and margins of the single balloon cell */
        let balloonD = 105
        layout.itemSize = CGSize(width: balloonD, height: balloonD)
        layout.sectionInset = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
    }
    
    // quick accessor to collectionView layout bypassing cast
    private var layout: UICollectionViewFlowLayout {
        return collectionView.collectionViewLayout as! UICollectionViewFlowLayout
    }
    
}

extension BalloonsStrip: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return movieStrip?.movies?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let movieCell = collectionView.dequeueReusableCell(withReuseIdentifier: BalloonCell.rID, for: indexPath) as! BalloonCell
        movieCell.movie = movieStrip?.movies?[indexPath.row]
        return movieCell
    }
    
}
