//
//  OuterCollectionViewCell.swift
//
//  Created by Najam Us Saqib on 4/7/23.
//

import UIKit

public class OuterCollectionViewCell: UICollectionViewCell {
    
    private var configured: Bool = false
    private(set) var innerCollectionView: InnerCollectionView!
    
    public var section: Int {
        set {
            innerCollectionView.section = newValue
        }
        get {
            return innerCollectionView.section
        }
    }
    
    public func configure(with classesReuseRegistry: [String: AnyClass?], nibsReuseRegistry: [String: UINib?], listener: UICollectionViewDelegate & UICollectionViewDataSource) {
        guard !configured else {
            return
        }
        
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        
        innerCollectionView = InnerCollectionView(frame: .zero, collectionViewLayout: layout)
        innerCollectionView.clipsToBounds = false
        innerCollectionView.backgroundColor = .clear
        innerCollectionView.showsHorizontalScrollIndicator = false
        contentView.addSubview(innerCollectionView)
        
        for classReuseInfo in classesReuseRegistry {
            innerCollectionView.register(classReuseInfo.value, forCellWithReuseIdentifier: classReuseInfo.key)
        }
        
        for (key, value) in nibsReuseRegistry {
            innerCollectionView.register(value, forCellWithReuseIdentifier: key)
        }
        
        innerCollectionView.delegate = listener
        innerCollectionView.dataSource = listener
        
        configured = true
    }
    
    override public func layoutSubviews() {
        super.layoutSubviews()
        innerCollectionView.frame = contentView.bounds
    }
    
    override public func prepareForReuse() {
        super.prepareForReuse()
        innerCollectionView.setContentOffset(innerCollectionView.contentOffset, animated: false)
    }
}
